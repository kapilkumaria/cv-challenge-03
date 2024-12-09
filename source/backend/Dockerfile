# Use a lightweight Python base image
FROM python:3.10-slim

# Set working directory inside the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential libpq-dev curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN pip install --no-cache-dir poetry

# Copy dependency files for Poetry
COPY pyproject.toml poetry.lock /app/

# Install dependencies using Poetry
RUN poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction --no-ansi

# Copy the entire backend project
COPY . /app

# Set the PYTHONPATH for proper module resolution
ENV PYTHONPATH=/app

# Download and add wait-for-it.sh script for PostgreSQL readiness
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /usr/bin/wait-for-it
RUN chmod +x /usr/bin/wait-for-it

# Expose the port FastAPI will run on
EXPOSE 8000

# Run wait-for-it.sh to wait for PostgreSQL, then start the server
CMD ["bash", "-c", "wait-for-it postgres:5432 -- ./prestart.sh && uvicorn app.main:app --host 0.0.0.0 --port 8000"]