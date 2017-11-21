# Ecto with Composable Queries

This application follows the blog article that discusses composable queries with Ecto. With this repo, you can follow along by checking out branch [10-with-authentication](https://github.com/rbeene/ecto_example/tree/10-with-authentication). 

This branch contains a typical Phoenix 1.3 setup with a number of tables and seeds. 

### Instructions

  * checkout the branch `10-with-authentication`
  * `mix ecto.reset`
  * (optionally) load the Postman collection to test
  * `mix phx.server`

### Users

Each user uses the password `test1234` but should have different levels of access based on role. The purpose of this repo is show a working example and give developers the opportunity to develop a solution alongside the blog article.

### Completed Example

Please checkout branch [20-with-filtering-by-role-and-params](https://github.com/rbeene/ecto_example/tree/20-with-filtering-by-role-and-params) for the complete example.

To review our refactor from part 2, checkout the [30-refactor-2](https://github.com/rbeene/ecto_example/tree/30-refactor-2) branch. 
