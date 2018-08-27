all : clean venv requirements dataset model test image

clean :
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -rf {} +
	find . -name '.pytest_cache' -exec rm -rf {} +
	docker container ls -a | awk '/headline/ {print $$1}' | xargs docker container rm
	docker image ls | awk '/headline/ { print $$1":"$$2 }' | xargs docker image rm

venv :
	python3 -m venv venv

requirements :
	venv/bin/pip install -r requirements.txt

dataset :
	venv/bin/kaggle datasets download \
		-p headline/resources/data \
		-d rmisra/news-category-dataset

model : name = model.pkl
model :
	venv/bin/python headline/train_model.py $(name)

test : path = tests
test :
	-venv/bin/pytest $(path)

image : tag = latest
image :
	docker build -t headline:$(tag) .

run : env = development
run : host = 127.0.0.1
run : port = 5000
run :
	FLASK_APP=headline FLASK_ENV=$(env) venv/bin/flask run \
		--host $(host) \
		--port $(port)

run-container : tag = latest
run-container : image
	docker run -p 5000:5000 headline:$(tag)
