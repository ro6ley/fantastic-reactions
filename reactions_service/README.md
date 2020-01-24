# ReactionsService

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Endpoints

Post a new reaction:

- endpoint: `localhost:4000/api/reactions` (**POST**)
- payload: 
  ```json
  {
    "action":"remove",
    "content_id":"12",
    "reaction_type":"fire",
    "type":"reaction",
    "user_id":"17"
  }
  ```

- success response:
  ```json
  {
    "msg":"Reaction added"
  }
  ```

Get the number of reactions on content:
- endpoint: `localhost:4000/api/reactions/<content-id>` (**GET**)
- success response:
  ```json
  {
    "content_id": "056af-2ef3",
    "reaction_count": {
        "fire": 1
    }
  }
  ```

## Assumptions

- Reaction types and their metadata are not maintained or controlled in this service
- The reactions are to be persisted later by the same service after a set period of time or certain limits are achieved


## Reasons for using ETS instead of third party caching solutions

- It requires no additional dependencies since ETS is part of the Erlang VM,
- It allows me store Elixir data structures thus eliminating the need for serialization and enhancing speed,
- The service was to be deployed on a single node, ETS makes the solution simpler,
- Other third-party solutions such as ConCache are built on top of the ETS,


## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
