## retrofit_cli

Dart Retrofit API Generator (🚧 under construction 🚧)

### Install

```sh
dart pub global activate retrofit_cli
```

#### Install from source

```sh
dart pub global activate --source=git https://github.com/luiscib3r/retrofit_cli.git
```

or

```sh
git clone https://github.com/luiscib3r/retrofit_cli.git
cd retrofit_cli
make install
```

### Usage

#### Example of `api.yaml`

```yaml
name: Todos
endpoints:
  - name: getTodos
    method: GET
    url: /todos
    response: |
      [
        {
          "id": "idstring",
          "name": "todo name",
          "description": "todo description",
          "price": 2.5,
          "count": 3
        }
      ]
  - name: getTodo
    method: GET
    url: /todos/{id}
    paths:
      - id: String
    response: |
      {
        "id": "idstring",
        "name": "todo name",
        "description": "todo description",
        "price": 2.5,
        "count": 3
      }
  - name: saveTodo
    method: POST
    url: /todos
    headers:
      - Authorization
    payload: |
      {
        "name": "todo name",
        "description": "todo description"
      }
    response: |
      {
        "id": "idstring",
        "name": "todo",
        "description": "desc1",
        "price": 0.0,
        "count": 0
      }
  - name: updateTodo
    method: PUT
    url: /todos/{id}
    headers:
      - Authorization
    paths:
      - id: String
    payload: |
      {
        "name": "new todo name",
        "description": "new todo description"
      }
    response: |
      {
        "id": "idstring",
        "name": "new todo name",
        "description": "new todo description"
      }
  - name: deleteTodo
    method: DELETE
    url: /todos/{id}
    headers:
      - Authorization
    paths:
      - id: String
    response: |
      {}
```

```sh
retrofit_cli api
```

```sh
retrofit_cli api -o api_package_name
```

```sh
retrofit_cli api -o api_package_name -i my_api.yaml
```
