const String signupMutation = """
  mutation SignUp(
    \$firstName: String!, 
    \$lastName: String!, 
    \$email: String!, 
    \$password: String!
  ) {
    createUser(
      firstName: \$firstName, 
      lastName: \$lastName, 
      email: \$email, 
      password: \$password
    ) {
      success
      message
    }
  }
""";

const String signInMutation = """
  mutation Login(\$email: String!, \$password: String!) {
    signIn(email: \$email, password: \$password) {
      success
      message
      token
    }
  }
""";
const String retailerSignupMutation = """
  mutation RetailerSignUp(
    \$firstName: String!, 
    \$lastName: String!, 
    \$email: String!, 
    \$password: String!
  ) {
    createRetailer(
      firstName: \$firstName, 
      lastName: \$lastName, 
      email: \$email, 
      password: \$password
    ) {
      success
      message
    }
  }
""";

const String retailerSignInMutation = """
  mutation Login(\$email: String!, \$password: String!) {
    retailerSignIn(email: \$email, password: \$password) {
      success
      message
      token
    }
  }
""";
