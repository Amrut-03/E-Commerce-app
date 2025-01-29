const String productCRUDOperations = """
  mutaion Product(
    \$name: String!, \$price: float!, \$description: String!, \$category: String!,\$imageURL: String!
  )Product(\$name: name, \$price: price, \$description: description, \$category: category,\$imageURL: imageURL){
    success
    message
  }
""";
