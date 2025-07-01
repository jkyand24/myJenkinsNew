# -------- base image --------
FROM python:3.11-slim AS base

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# -------- test stage --------
FROM base AS test
RUN pip install pytest
CMD ["pytest", "test_app.py"]

# -------- final runtime image --------
FROM base AS final
EXPOSE 5000
CMD ["python", "app.py"]
