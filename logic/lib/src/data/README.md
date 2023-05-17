# Data

This is Data-layer. It responsible for communication with external data providers, such as Web API or databases.

This is private layer and should not be accessible outside of `data` and `repositories`. **It should not be used in the apps directly.**

## Contract

This is common rules for the layer:

1. There can be used external packages (http client, databases)
2. It can depend only on domain layer. It should be **completely** independent from presentation layer.
3. **API** consists of
   * request models - models we pass to request as param
   * response models - models we receive after successful or unsuccessful (errors) response
   * requests - functions that accepts request models and returns response models

## Supernode API

Supernode API, originally generated using Swagger file taken from build server - <https://lora.build.cloud.mxc.org/swagger/api.swagger.json>

Models, responses and requests are taken from swagger file, there's no hand-writed code in this part. API methods are splitted by services, which you can see in swagger page - <https://lora.build.cloud.mxc.org/api>.  

The code was generated using forked version of `swagger_dart_code_generator` package.
What changes were applied to the fork:

* Some calls in the swagger have dot in param names (like `user.id` in `/api/users/{user.id}`). This causes generation errors in the original version and has been fixed in the fork.
* In the original version all requests stored in 1 class, in fork they are splitted by service name.
* `create` method (factory method which supposed to create service) was renamed to `createService` to avoid conflicts with the swagger methods.

If you want to regenerate these files (in case some new methods appeared, e.g.), follow these steps:

* Get your **swagger file** from [lora_server_address]/swagger/api.swagger.json
* Parse **swagger file** with json beautifier, for example: <https://jsonformatter.curiousconcept.com/>
* Replace `[mxc_shared]/logic/swagger/supernode.swagger` with beautified **swagger file**
* Run `pub run build_runner build` or `flutter pub run build_runner build`
