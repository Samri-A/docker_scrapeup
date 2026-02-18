FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

COPY requirements.txt requirements-test.txt ./
RUN python -m pip install --upgrade pip \
    && python -m pip install -r requirements-test.txt

COPY . .
RUN python -m pip install --no-deps .

CMD ["python", "-m", "pytest", "-q", "--ignore=tests/e2e", "--ignore=tests/performance"]
