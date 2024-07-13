with
    rennamed as (
        select
            cast(ID as int) as pk_categoria
            , cast(CATEGORYNAME as varchar) as nome_categoria
            , cast(DESCRIPTION as varchar) as descricao_categoria
        from {{ source('erp', 'category') }}
    )
select *
from rennamed