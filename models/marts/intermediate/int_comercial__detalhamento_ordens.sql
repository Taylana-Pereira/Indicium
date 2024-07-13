with
    ordens as (
        select *
        from {{ ref('stg_erp__ordens') }}
    )
    , ordens_detalhes as (
        select *
        from {{ ref('stg_erp__ordens_detalhes') }}
    )
    , joined as (
        select
            ordens_detalhes.FK_PEDIDO
            , ordens_detalhes.FK_PRODUTO
            , ordens.FK_FUNCIONARIO
            , ordens.FK_CLIENTE
            , ordens.FK_TRANSPORTADORA
            , ordens.DATA_DO_PEDIDO
            , ordens.DATA_DO_ENVIO
            , ordens.DATA_REQUERIDA_ENTREGA
            , ordens.FRETE
            , ordens_detalhes.DESCONTO_PERC
            , ordens_detalhes.PRECO_DA_UNIDADE
            , ordens_detalhes.QUANTIDADE
            , ordens.NM_DESTINATARIO
            , ordens.CIDADE_DESTINATARIO
            , ordens.REGIAO_DESTINATARIO
            , ordens.PAIS_DESTINATARIO
        from ordens_detalhes
        inner join ordens
            on ordens_detalhes.fk_pedido = ordens.pk_pedido
    )
    , metricas as (
        select
            *
            , PRECO_DA_UNIDADE * QUANTIDADE as total_bruto
            , PRECO_DA_UNIDADE * (1 - DESCONTO_PERC) * QUANTIDADE as total_liquido
            , FRETE / count(*) over(partition by fk_pedido) as frete_rateado
            , PRECO_DA_UNIDADE
                * (1 - DESCONTO_PERC)
                * QUANTIDADE
                - FRETE / count(*) over(partition by fk_pedido)
            as lucro
        from joined
    )
    , chave_primaria as (
        select
            fk_pedido::varchar || '-' || fk_produto::varchar as sk_vendas
            , *
        from metricas
    )
select *
from chave_primaria