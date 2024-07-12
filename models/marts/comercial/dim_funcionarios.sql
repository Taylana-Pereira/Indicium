with
    stg_funcionarios as (
        select *
        from {{ ref('stg_erp_funcionarios') }}
    )
    , joined as (
        select
            funcionaros.PK_FUNCIONARIO
            , funcionaros.NOME_FUNCIONARIO
            , gerentes.NOME_FUNCIONARIO as nome_gerente
            , funcionaros.FUNCAO_FUNCIONARIO
            , funcionaros.DT_NASCIMENTO
            , funcionaros.DT_CONTRACAO
            , funcionaros.CIDADE_FUNCIONARIO
            , funcionaros.PAIS_FUNCIONARIO
        from stg_funcionarios as funcionaros
        left join stg_funcionarios as gerentes
            on funcionaros.fk_gerente = gerentes.pk_funcionario
    )
select *
from joined