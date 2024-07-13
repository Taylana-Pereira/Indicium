with
    categorias as (
        select *
        from {{ ref('stg_erp__categorias') }}
    )
    , produtos as (
        select *
        from {{ ref('stg_erp__produtos') }}
    )
    , joined as (
        select
            produtos.PK_PRODUTO
            , produtos.FK_FORNECEDOR
            , produtos.NM_PRODUTO
            , categorias.NOME_CATEGORIA
            , produtos.QUANTIDADE_POR_UNIDADE
            , produtos.PRECO_POR_UNIDADE
            , produtos.UNIDADE_EM_ESTOQUE
            , produtos.UNIDADE_POR_PEDIDO
            , produtos.NIVEL_DE_PEDIDO
            , produtos.EH_DISCONTINUADO
        from produtos
        left join categorias
            on produtos.fk_categoria = categorias.pk_categoria
    )
select *
from joined