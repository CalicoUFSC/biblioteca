Guia de Contribuição
====================

Como contribuir para Biblioteca Virtual do CALICO:


Passo 1:
--------

Faça um [fork](https://github.com/CalicoUFSC/biblioteca/fork) do repositório.


Passo 2:
--------

Caso o material seja um arquivo, faça upload em algum serviço de hospedagem de arquivos de sua prefêrencia. Certifique-se de que a URL não tem data de expiração e nem será alterada.

Caso sejam vários arquivos relacionados (por exemplo, um conjunto de slides), compacte-os em um único arquivo antes de fazer o upload (use de preferência o formato `.tgz`).

O CALICO se reserva o direito de fazer reupload dos arquivos.

Caso seja um link de terceiros (por exemplo, video no YouTube ou site), este passo não é necessário.


Passo 3:
--------

Em posse do link, vá até o arquivo que deseja adicionar o material, e adicione uma nova entrada.


Antes:

```json
{
    "id": "ABC1234",
    "name": "Disciplina A",
    "term": 3,

    "entries": [
        {
            "type": "Livro",
            "title": "Fundamentos da Disciplina A",
            "author": "João da Silva",
            "comment": "Terceira edição",
            "link": "http://link.com/joao/fundamentos"
        }
    ]
}
```

Depois:

```json
{
    "id": "ABC1234",
    "name": "Disciplina A",
    "term": 3,

    "entries": [
        {
            "type": "Livro",
            "title": "Fundamentos da disciplina A",
            "author": "João da Silva",
            "comment": "Terceira edição",
            "link": "http://link.com/joao/fundamentos"
        },
        {
            "type": "Videoaula",
            "title": "Disciplina A e suas aplicações",
            "author": "Maria Joana",
            "link": "http://video.com/maria/aplicacoes"
        }
    ]
}
```


Passo 4:
--------

Execute o arquivo `scripts/build.sh`, caso ele indique algum erro, corrija-os e começe o passo 4 novamente.

Leia a especificação to [template](#template) caso tenha alguma dúvida de como os JSONs são organizados.


Passo 5:
--------

Adicione seu nome e username no arquivo [AUTHORS.md](AUTHORS.md), respeitando a ordem alfabética.


Passo 6:
--------

Faça um commit com suas alterações e abra um Pull Request. :tada:


<a name="template"></a>Template para JSONs
===================

```json
{
    "id": "ABC1234",
    "name": "Disciplina A",
    "term": 3,

    "entries": [
        {
            "type": "Livro",
            "title": "Fundamentos da disciplina A",
            "author": "João da Silva",
            "comment": "Terceira edição",
            "link": "http://link.com/joao/fundamentos"
        },
        {
            "type": "Videoaula",
            "title": "Disciplina A e suas aplicações",
            "author": "Maria Joana",
            "link": "http://video.com/maria/aplicacoes"
        },
        {
            "title": "Provas anteriores",
            "link": "http://provas.com/disciplina-a"
        }
    ]
}
```

#### Os objetos JSON que representam uma disciplina possuem os seguintes campos:

* **id**: (string) código da disciplina (deve respeitar o regex `[A-Z]{3}\d{4}`)

* **nome**: (string) nome da disciplina

* **term**: (int ou null) fase da disciplina, deve estar entre 1 e 8 (inclusivo) ou ser null caso a disciplina seja optativa

* **entries**: (lista) lista de objetos **entry**

Todos estes campos são obrigatórios.


#### Os objetos **entry** possuem os seguintes campos:

* **type**: (string) tipo de material (por exemplo, Livro ou Videoaula)

* **title**: (string) título que descreve o material

* **author**: (string) autor do material

* **comment**: (string) comentários sobre o material (senha para o PDF ou edição do livro)

* **link**: (string) link para o material

Os campos **title** e **link** são obrigatórios. Os outros campos devem ser adicionados se forem relevantes ao material.
