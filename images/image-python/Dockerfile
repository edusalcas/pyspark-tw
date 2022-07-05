FROM conda/miniconda3

# Create user
RUN groupadd pyuser && \
	useradd -d /home/pyuser -g pyuser -m pyuser --shell /bin/bash

# Install packages
COPY config/requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && \
	pip install -r /tmp/requirements.txt

RUN mkdir /home/pyuser/documents && \
	mkdir /home/pyuser/.jupyter

COPY config/jupyter_notebook_config.json config/jupyter_notebook_config.py config/migrated \
	 /home/pyuser/.jupyter/

RUN chown -R pyuser:pyuser /home/pyuser

USER pyuser

ENTRYPOINT ["sh", "-c", "jupyter-notebook --ip '*' --port 8888 --no-browser --notebook-dir=~/documents/"]

VOLUME /home/pyuser/documents
