def hello_world(request):
    """HTTP Cloud Function that returns a simple "Hello world!" message.
    
    Args:
        request (flask.Request): The request object.
    Returns:
        The response text, or any set of values that can be turned into a
        Response object using `make_response`.
    """
    return "Hello world!"