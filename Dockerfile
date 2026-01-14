FROM ruby:4.0

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Copy gemspec/Gemfile if present to speed up bundle install
COPY Gemfile* ./

RUN gem install bundler -v "~> 2.4" || true
RUN if [ -f Gemfile ]; then bundle install --jobs 4 --retry 3; fi

# Copy the rest of the source
COPY . .

# Default command: open a shell for development
CMD ["bash"]
