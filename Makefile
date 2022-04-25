install: # полезна при первом клонировании репозитория (или после удаления зависимостей)
	bundle install

lint: # check all Ruby source files in the current directory
	bundle exec rubocop lib/ test/ 

test: # run all tests in ./test/
	bundle exec rake test

.PHONY: test
