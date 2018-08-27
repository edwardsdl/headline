# Headline
## Getting Started
Before you begin, verify that you have GNU Make installed and you've downloaded your [Kaggle API credentials](https://github.com/Kaggle/kaggle-api#api-credentials). Once you're ready, run the `make` command in the project's root directory. This performs the following tasks:
1) Creates a new virtual environment
1) Installs all packages specified in `requirements.txt` in the new virtual environment
1) Downloads the [News Category Dataset](https://www.kaggle.com/rmisra/news-category-dataset/home) from [Kaggle](https://www.kaggle.com) and places it in `headline/resources/data/`
1) Trains a model using the downloaded dataset
1) Builds a new Docker image with everything needed to run Headline

## Running the Application
After running `make`, you'll have everything you need to run Headline both locally and inside a Docker container. To run the application locally, execute `make run`. If you prefer to run it inside a Docker container, instead execute `make run-container`.

In either case, you can interact with the application at [http://localhost:5000](http://localhost:5000). It exposes the following endpoints:

`GET` `/ping`  This is used to verify the container is running and accepting connections.

`GET` `/classification?entry=<URL>` Given a link to a HuffPost entry, this route classifies it as crime, entertainment, world news, etc.

## Training the Model
If you decide to make modifications to the prediction code, simply run `make model` to generate an updated model. By default it will be stored in `headline/resources/models/model.pkl`.
 
You can override the name of the model using the `name` argument. For example, `make model name=model_v2.pkl` would create an updated model at `headline/resources/model/model_v2.pkl`. Of course, if you wish to use this new model you'll need to update the application to reference it.

## Building the Docker Image
You can build a new docker image at any time by running `make image`. By default this will create a new image named `headline:latest`. You can override the tag with the `tag` argument. For example, `make image tag=2.0` will produce an imaged named `headline:2.0`.

## Executing the Unit Test Suite
You'll find all of Headline's tests in the `tests` directory. To execute them, run `make test`.
