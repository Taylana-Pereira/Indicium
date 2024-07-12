with
    rennamed as (
        select
            cast(ID as int) as pk_funcionario
            , cast(REPORTSTO as varchar) as fk_gerente
            , cast(FIRSTNAME as varchar) || ' ' || cast(LASTNAME as varchar) as nome_funcionario
            , cast(TITLE as varchar) as funcao_funcionario
            , cast(BIRTHDATE as date) as dt_nascimento
            , cast(HIREDATE as date) as dt_contracao
            , cast(CITY as varchar) as cidade_funcionario
            , cast(COUNTRY as varchar) as pais_funcionario
            --ADDRESS
            --TITLEOFCOURTESY
            --REGION --não vai ser usado agora
            --POSTALCODE
            --HOMEPHONE
            --EXTENSION
            --PHOTO
            --NOTES
            --PHOTOPATH
        from {{ source('erp', 'employee') }}
    )
select *
from rennamed