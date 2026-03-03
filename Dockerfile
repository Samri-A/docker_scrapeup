FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt requirements-dev.txt requirements-opts.txt ./
RUN pip install --no-cache-dir -r requirements.txt -r requirements-dev.txt -r requirements-opts.txt

COPY . .

CMD ["pytest", "tests", "-m", "not req"]
