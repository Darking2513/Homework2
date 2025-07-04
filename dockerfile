# Базовий образ Python 3.13 slim
FROM python:3.13-slim

# Оновлення та встановлення curl для установки poetry
RUN apt-get update && apt-get install -y curl

# Встановлюємо poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Додаємо poetry у PATH
ENV PATH="/root/.local/bin:$PATH"

# Робоча директорія
WORKDIR /app

# Копіюємо файли pyproject.toml, poetry.lock, README.md (якщо є)
COPY pyproject.toml poetry.lock README.md* /app/

# Встановлюємо залежності без встановлення самого пакету (--no-root)
RUN poetry config virtualenvs.create false \
    && poetry install --no-root --no-interaction --no-ansi

# Копіюємо весь код проєкту
COPY . /app

CMD ["python", "assistant.py"]