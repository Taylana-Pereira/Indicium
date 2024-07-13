with
    dim_produtos as (
        select *
        from {{ ref('dim_produtos') }}
    )
    , dim_funcionarios as (
        select *
        from {{ ref('dim_funcionarios') }}
    )
    , int_vendas as (
        select *
        from {{ ref('int_comercial__detalhamento_ordens') }}
    )
    , joined as (
        select
            int_vendas.SK_VENDAS
            , int_vendas.FK_PRODUTO
            , int_vendas.FK_FUNCIONARIO
            , int_vendas.FK_CLIENTE
            , int_vendas.FK_TRANSPORTADORA
            , dim_produtos.FK_FORNECEDOR
            , int_vendas.DATA_DO_PEDIDO
            , int_vendas.DATA_DO_ENVIO
            , int_vendas.DATA_REQUERIDA_ENTREGA
            , int_vendas.TOTAL_BRUTO
            , int_vendas.TOTAL_LIQUIDO
            , int_vendas.FRETE_RATEADO
            , int_vendas.LUCRO
            , int_vendas.FRETE
            , int_vendas.DESCONTO_PERC
            , int_vendas.PRECO_DA_UNIDADE
            , int_vendas.QUANTIDADE
            , int_vendas.FK_PEDIDO as nota_fiscal
            , int_vendas.NM_DESTINATARIO
            , int_vendas.CIDADE_DESTINATARIO
            , int_vendas.REGIAO_DESTINATARIO
            , int_vendas.PAIS_DESTINATARIO
            , dim_produtos.NM_PRODUTO
            , dim_produtos.NOME_CATEGORIA
            , dim_funcionarios.NOME_FUNCIONARIO
            , dim_funcionarios.NOME_GERENTE
        from int_vendas
        left join dim_produtos
            on int_vendas.fk_produto = dim_produtos.pk_produto
        left join dim_funcionarios
            on int_vendas.fk_funcionario = dim_funcionarios.pk_funcionario
    )
select *
from joined