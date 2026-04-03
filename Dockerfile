FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Required by PyGObject/GTK and the project test stack.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        gettext \
        gobject-introspection \
        libgirepository1.0-dev \
        libcairo2-dev \
        pkg-config \
        python3-dev \
        gir1.2-gtk-3.0 \
        gir1.2-gtksource-4 \
        xvfb \
        xauth \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN pip install --no-cache-dir -e ".[test]"

CMD ["python", "tests/test.py", "--start-dir", "unit"]
