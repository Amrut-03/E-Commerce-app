const String getProductsQuery = """
    query getProducts {
      getProducts {
        id
        name
        price
        description
        category
        imageURL
      }
    }
  """;
