# FIAP Boletim API
This is a simple [Sinatra](http://sinatrarb.com/) app that returns student information as an JSON from [FIAP](https://www.fiap.com.br/) site.

## Developing and Deploying
You need Docker and Docker Compose to run server:

```bash
docker-compose up
```

## Requesting

There is just one endpoint that receives Student information and returns grades from college's website.

```
POST /notas
  Body: {
    "rm": "xxxxx",
    "senha": "$3Cr3T"
  }

  Response:
    401 - When user data is invalid
    200 - When user data is correct and request was successful
      [
        {
          "id": 1324,
          "disciplina": "Math",
          "nac1": 10.0,
          "am1": 8.0,
          "ps1": 9.0,
          "md1": 8.9,
          "nac2": null,
          "am2": null,
          "ps2": null,
          "md2": null,
          "aulas": 90,
          "faltas1": 0,
          "faltas2": null,
          "presenca": 100,
          "mp": null,
          "exame": null,
          "mf": null,
          "situacao": ""
        },
        ...
      ]
  ```