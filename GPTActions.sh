################## Demo Outline

# The first thing to note here is that we do this demo on the ChatGPT interface - we do NOT
# use the SDK and we do not use the OpenAI dashboard and projects. Anyone with a paid ChatGPT
# account will be able to perform this demo (this demo involves creating custom GPTs)

# This demo involves the creation of a custom GPT that will use GPT Actions to make API calls to real world APIs in order to respond to your queries

#############################################################################
# 1. Open Library Search API - explore the API to integrate in the custom GPT
# 2. Use another custom GPT (Actions GPT) to generate the OpenAPI spec for the Library API 
# 3. Configure our own custom GPT to make API calls to the Library API
# 4. Set up the GPT Action that actually integrates with the API
# 5. Query the custom GPT and verify the model invokes the API to get the response
# 6. Explore the Weather API (a different API to integrate with our GPT)
# 7. Create and test a Custom GPT for the Weather API
# 8. Create a custom GPT integrating with the Words API that uses authentication via an API key
#############################################################################


################## Custom GPTs

# Custom GPTs are personalized versions of ChatGPT that you can create and configure for specific tasks or domains without needing to write code. You can customize them by providing instructions, uploading knowledge files, enabling specific tools (like web search or code interpreter), and setting custom actions to perform specialized functions. Custom GPTs allow you to bundle your expertise, documents, and workflows into a reusable assistant that you can share with others or use privately.

-------------------------------------
################## GPT Actions

# GPT Actions are stored in Custom GPTs, which enable users to customize ChatGPT for specific use cases by providing instructions, attaching documents as knowledge, and connecting to 3rd party services.
# GPT Actions empower ChatGPT users to interact with external applications via RESTful APIs calls outside of ChatGPT simply by using natural language. They convert natural language text into the json schema required for an API call. GPT Actions are usually either used to do data retrieval to ChatGPT (e.g. query a Data Warehouse) or take action in another application (e.g. file a JIRA ticket).

# You can create "Custom GPTs" that are wired up to connect to APIs that you set up
# You must provide an OpenAPI specification, and configure authentication if required
# The model will then automatically know when to call the right API based on the user prompt (the model will extract the user's intent from the prompt to call the API)
-------------------------------------

#############################################################################
# 1/8. Open Library Search API - explore the API to integrate in the custom GPT
#############################################################################

# First go to 

https://openlibrary.org/dev/docs/api/search

# Just click on the main URL and show:

https://openlibrary.org/search.json

# You can see the structure of the response

# IMPORTANT:
# Click on some of the link examples on this page and show the result

-----------------------------------------------
######### OpenAPI specs

# Now in order for ChatGPT to know of this API and how to use the API we need the OpenAPI (please note OpenAPI NOT OpenAI) specification for the API.

# The OpenAPI Specification (OAS) is a language-agnostic standard for defining and describing RESTful APIs in a machine-readable format, typically using YAML or JSON. It allows both humans and computers to discover and understand an API's capabilities—including its available endpoints, operations, and parameters—without needing access to the source code. This specification is widely used by tools to automatically generate interactive documentation, client code, and server stubs, which streamlines the development and integration process.

# This allows “Custom GPTs” to know how to call the API automatically.

# Overall: you prepare your API → draft an OpenAPI spec → register it as an Action for your custom GPT → the GPT uses that spec to map natural-language user intents into API calls, then processes the API response and continues the conversation. 
-----------------------------------------------

# First, we must generate the OpenAPI spec
# Open chatgpt.com
# Click on Explore GPTs

-----------------------------------------------
######### **Custom GPT** 
# NEW CONCEPT: **Custom GPT** 
# Custom GPTs are personalized versions of ChatGPT that you can create for a specific purpose, task, or topic. Instead of using the general-purpose, one-size-fits-all ChatGPT, you can build a specialized "GPT" that is tailored to your exact needs.
# The "Actions GPT" that we use here is a custom GPT that can scrape a website documentation and generate an Open API specification for the APIs documented on that website
-----------------------------------------------

#############################################################################
# 2/8. Use another custom GPT (Actions GPT) to generate the OpenAPI spec for the Library API 
#############################################################################
# Search for "Actions GPT"
# Send it this prompt:

Generate a complete OpenAPI 3.1.0 YAML specification for the Open Library Search API by reading the documentation at https://openlibrary.org/dev/docs/api/search and including the GET operations for /search.json (with query parameters 'q', 'limit', 'fields') and /search/authors.json (with for query parameter'q').

# It generates an OpenAPI spec
# Note how it has read, and links to the docs for this API

# This API is completely free, and can be accessed without auth
# The next step for us is to create a new Custom GPT and use this

-----------------------------------------------
##### Explanation of OpenAPI spec (this level of detail is sufficient for the specification, don't worry about explaining this in more detail):

# `openapi: 3.1.0` — declares this specification uses version 3.1.0 of the OpenAPI Specification standard.  
# `info:` block — metadata about the API: title ("Open Library Search API"), description (what it does), and version number ("1.0.0").  
# `servers:` list — defines one or more server URLs where the API is available (here: `https://openlibrary.org`, labelled as the main production server).  
# `paths:` — specifies the available API endpoints under the server:  
  # `/search.json:` (GET) — operationId `searchBooks`, summary "Search for books", with query parameters `q` (required search term), `limit` (optional integer), `fields` (optional string) and 200-response schema that returns `numFound`, `start`, and `docs` list.  
  # `/search/authors.json:` (GET) — operationId `searchAuthors`, summary "Search for authors", with required query parameter `q`, and 200-response schema returning `numFound`, `start`, and `docs` list.  
# For each `get` operation: parameters are defined by `name`, `in` (query), `required`, `description`, and `schema`; the `responses:` section maps status codes (e.g. `'200'`) to content types and schema definitions.  
-----------------------------------------------



#############################################################################
# 3/8. Configure our own custom GPT to make API calls to the Library API
#############################################################################


# DO THIS ON A NEW TAB
# Click on Explore GPTs --> My GPTs

# Select the Configure option to create new GPT
# Call this LibraryGPT

# Instructions
Access the Open Library API and retrieve the information the user requests
# NEW CONCEPT: **Custom GPT** – a special GPT instance configured with actions (APIs) and instructions, distinct from a plain chat prompt.

# Generate an image using DALL-E for this

# In the original tab
# NEW: Using an image-generation action (DALL-E) alongside the API call shows Multi-Modal workflow (text + image).

Can you generate an image showing a library of books?

# Download the image

# Go back to the tab where we were creating a new GPT

# Click on "Upload photo" and upload the image (this failed for me, just move on if that happens and we will cut out this bit)

--------------------------------------

##### Other tools enabled on GPTs
# Web Search Tool: Enables the GPT to query live web pages for up-to-date information and cite sources. 
# File Search / Document Retrieval Tool: Lets the GPT access uploaded files (PDFs, docs, spreadsheets) so it can pull from your custom knowledge base.
# Code Interpreter & Data Analysis Tool: Allows the GPT to run Python code or perform data manipulation tasks directly (e.g., analytics or transformation). 
# Image Generation / Canvas Tool: Allows the GPT to generate or edit images (creating visuals tied to its responses or tasks). 
# Custom Action / API Integration Tool: Enables the GPT to call your own external service or API (e.g., database lookup, CRM update) via a defined action manifest. 
--------------------------------------

#############################################################################
# 4/8. Set up the GPT Action that actually integrates with the API
#############################################################################

--------------------------------------
###### GPT Actions

# GPT actions are integrations that allow Custom GPTs to interact with external APIs and services to perform real-world tasks beyond just text generation. With actions, you can connect your GPT to external systems like databases, CRM platforms, project management tools, or any API-enabled service to fetch data, update records, or trigger workflows. This enables your Custom GPT to be more dynamic and useful by bridging the gap between conversation and actual business operations.
--------------------------------------

# Click on "Create new action"
# Copy the OpenAPI spec from earlier and paste it here
# Click on the Authentication dropdown
# Click on each option
# Go back to None – we don't need any for this API
# We can leave the Privacy Policy blank


--------------------------------------
###### Explanation of Authentication Methods:
# None: No authentication required — the API endpoint is publicly accessible without credentials.  
# API Key: A static secret key provided to a client, included in headers or query parameters to authenticate requests.  
# OAuth: A token-based authorization framework where clients obtain access tokens (often via user consent or service credentials) to access the API.  
--------------------------------------

# We can now see 2 APIs accessed here – one for books, the other for authors
# Click on Test for each of these in turn

# See the response and the parameters

# For /search.json - look at the "q" parameter to see what the query is
# For /search/authors.json - look at the "q" parameter to see what the query is

# We can see how it connects to the API, asks for authorization (choose Allow Every Time), gets the response back, and then phrases its own response accordingly

--------------

# Now, go ahead and create the GPT
# We can see it in our sidebar on the home page of ChatGPT

#############################################################################
# 5/8. Query the custom GPT and verify the model invokes the API to get the response
#############################################################################


# Click on it, and ask the following prompts:

Tell me about the book A Tale of Two Cities.

# Expand the API call and show

I am curious about about author George Orwell. What books of his are available in Open Library?

# Expand the API call and show


#############################################################################
# 6/8. Explore the Weather API (a different API to integrate with our GPT)
#############################################################################

######### Open Meteo Weather

# Let's try the same process for another auth-less API

# Go to

https://open-meteo.com/en/docs

# Show the API documentation here

# Open up our ActionsGPT session
# Give it this prompt:

Generate a complete OpenAPI 3.1.0 YAML specification for the Open-Meteo Weather Forecast API by reading the documentation at https://open-meteo.com/en/docs and including the GET operation for /v1/forecast, ensuring it includes the required 'latitude' and 'longitude', and the high-value optional parameters 'daily', 'hourly', and 'timezone'. 

# This is to get weather forecasts for a specific location

# Again, the response includes references to the official API docs
# Go ahead and copy the OpenAPI spec

--------------------------------------
### Explanation for OpenAPI spec for this API

# openapi: 3.1.0 — declares that this specification follows version 3.1.0 of the OpenAPI standard.
# info: { title, description, version } — provides metadata: the API name (“Open-Meteo Weather Forecast API”), description of its purpose (world-wide weather forecast), and version “1.0.0”.
# servers: [ { url: https://api.open-meteo.com, description: Production server } ] — identifies the base URL and environment where this API is hosted.
# paths: /v1/forecast — defines one endpoint path (GET) to retrieve weather forecast data for given coordinates.
# GET /v1/forecast (operationId: getWeatherForecast) — describes the request for weather forecast for a location, with summary, description and query parameters.
# parameters: latitude (query, required, float) and longitude (query, required, float) — specify that the caller must supply geographic coordinates for the forecast.
# parameters: daily (optional string) — allows specifying comma-separated daily weather variables to return (e.g., max/min temperature).
# parameters: hourly (optional string) — allows specifying comma-separated hourly weather variables to return (e.g., temperature at 2 m, relative humidity).
# parameters: timezone (optional string) — allows setting the timezone of the returned timestamps (e.g., “Europe/Berlin” or “auto”).
# responses: '200' — defines the successful response schema: JSON object with properties latitude, longitude, generationtime_ms, utc_offset_seconds, timezone, timezone_abbreviation, elevation, current_weather, hourly, daily.
--------------------------------------


#############################################################################
# 7/8. Create and test a Custom GPT for the Weather API
#############################################################################

# Create another new custom GPT
# Name: WeatherGPT
# Instructions: 

Identify the latitude and longitude coordinates of the location the user asks for, and connect to the Open-Meteo API to get the weather forecast for that location.
# NEW CONCEPT: **Geocoding** (implied) – converting a location name into latitude/longitude before calling the weather API.

# Add a new action
# Copy the OpenAPI spec in
# Again, Authentication = None

# Test the forecast API

# click on Test a

# It gives us predictions for weather at some coordinates
# Save and create the custom GPT

# Open a new chat
# Ask it:
What is the weather forecast for New York City?

# It will connect to the API and respond

#############################################################################
# 8/8. Create a custom GPT integrating with the Words API that uses authentication 
# via an API key
#############################################################################

######### Words API

# Now, finally, let's try with an API that requires authentication

# Go to 

https://www.wordsapi.com/

# Go to "Try It" and show how it works (use word "subordinate")

# Cilck on "Pricing" and show plans


# Open ActionsGPT and give it this prompt:

Generate a complete OpenAPI 3.1.0 YAML specification for the WordsAPI by reading the documentation on RapidAPI for the Definitions endpoint and including the GET operation for /words/{word}/definitions. Ensure the spec defines security via the required 'X-RapidAPI-Key' header, and includes the required 'word' path parameter. 

--------------------------------------
# NEW CONCEPT: **API Key Authentication via header** – This shows how to specify in OpenAPI that a particular header (X-RapidAPI-Key) is required for access.

##### OpenAPI specification for this API:
# openapi: 3.1.0 — specifies that the document uses version 3.1.0 of the OpenAPI Specification.  
# info: { title: “WordsAPI Definitions Endpoint”, version: 1.0.0, description: … } — provides metadata describing the API’s purpose (retrieving word definitions via RapidAPI) and its version.  
# servers: [{ url: https://wordsapiv1.p.rapidapi.com, description: WordsAPI via RapidAPI (Production) }] — defines the base URL where the API is hosted in production.  
# paths: /words/{word}/definitions: — defines an endpoint path that takes a path parameter `word` and returns definitions for that word.  
# get: — declares that the HTTP method for this endpoint is GET, with operationId `getWordDefinitions`, a summary, and a longer description.  
# parameters: — lists the input variables: `word` is required in the path, type string, described as “The word to retrieve definitions for.”  
# security: — references a security scheme named `rapidApiKey`, meaning this endpoint requires API-key authentication.  
# responses: '200': — defines a successful response (HTTP status 200) with content type `application/json`, and a schema that returns an object containing `word` (string) and `definitions` (array of objects each with `definition` and `partOfSpeech`).  
# responses: '400', '401', '404', '500': — defines additional response statuses and descriptions for bad request, unauthorized (invalid key), not found, and server error respectively.  
# components: securitySchemes: rapidApiKey: — declares the authentication scheme: `type: apiKey`, location `in: header`, and header name `X-RapidAPI-Key`, meaning clients must include this header with a valid key.  
# components: schemas: {} — includes an (empty) placeholder for shared schema definitions; you could add reusable schemas here for complex responses or objects.  
--------------------------------------

# Again, it will connect to docs, and set this up

# Click on the link it provides - this API is on RapidAPI
# First, create a new account on RapidAPI
# Sign in with email - cloud.user

# Next, subscribe to the BASIC plan that costs $0
# This will give us an API key that we can use
# NEW CONCEPT: **Free tier subscription** – even though usage is free, you must still subscribe and manage keys.

# Note how this API key is sent in a header - X-RapidAPI-Key
# We have to configure this

# Create a new Custom GPT "WordsGPT"
# Instructions: 
Get word definitions using the Words API connector.

# Add a new action
# Copy the OpenAPI spec in
# Choose Authentication = API Key
# Choose Custom
# Header name: 'X-RapidAPI-Key'
# Save this

# Test the new API shown
# It should get the definition of a random word now from the API

# Save the new GPT
# Open a new chat
# Ask:

What is the meaning of the word "penultimate"?

# View the API call and response
