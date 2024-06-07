FROM python:3.9.19-alpine3.20

EXPOSE 8000
WORKDIR /app


ENV PYTHONDONTWRITEBYTECODE=1 \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_VERSION=1.1.11 


RUN apk add --no-cache python3-dev gcc libc-dev musl-dev openblas build-base

COPY ./ /app

# use built-in pip to access poetry 
RUN pip install poetry
RUN pip install -r requirements.txt

# start installing things with poetry
RUN poetry config virtualenvs.create false
RUN poetry install --no-interaction --no-ansi

#CMD ["uvicorn", "main:app"]
CMD ["poetry", "run", "-v", "python", "runserver.py"]