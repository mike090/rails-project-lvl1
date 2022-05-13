### Hexlet tests and linter status:
[![Actions Status](https://github.com/mike090/rails-project-lvl1/workflows/hexlet-check/badge.svg)](https://github.com/mike090/rails-project-lvl1/actions)
[![CI status](https://github.com/mike090/rails-project-lvl1/actions/workflows/main.yml/badge.svg)](https://github.com/mike090/rails-project-lvl1/actions)

Данный гем является итоговым проектом курса "Ruby: Основы языка" образовательной платформы [Hexlet](https://hexlet.io)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add late_commands

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install late_commands

## Usage

Гем является генератором форм и предоставляет для этого метод form_for, принимающий в качестве аргументов модель, атрибуты формы и блок, в который будет передан экземпляр класса HexletCode::Form в качестве аргумента. Этот объект используется для построения структуры будущей формы. Структура формы задается последовательным вызовом методов не объекте формы. Могут быть вызваны методы с любыми именами и следующими параметрами []|[String]|[Symbol], [_**attrs]. Имя метода будет именем нового контрола, а параметры и атрибуты, переданные аргументами, будут сохранены в структуре. Структура формы может быть получена через атрибут data. Так же, по атрибуту controls доступны контролы, созданные на форме. Атрибут возвращает массив объектов класса HexletCode::Controls::Control (или его наследников).

Для построения представления формы используется HexletCode::Rendering. Этот объект построит представление любого контрола, если предварительно зарегистрировать его (контрола) рендер. Для регистрации используется метод register_renderer, который принимает имя контрола и объект рендера. В качестве рендера может быть использован объект Proc или любой объект, отвечающий на метод :render. В качестве аргументу рендеру передается экземпляр контрола.

Примеры HTML рендеров можно найти в проекте.

### В какую сторону можно идти дальше

Можно попробовать научить форму строить контролы с другими параметрами, которые определят сами контролы. Можно научить форму узнавать контролы по имени, а не по параметрам.
Основной целью было научиться построению гибкого, расширяемого приложения.
Практической ценности этот гем не имеет.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/late_commands. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/late_commands/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LateCommands project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/late_commands/blob/master/CODE_OF_CONDUCT.md).