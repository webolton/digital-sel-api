# Digital SEL API

> Nou blouweþ þe niwe frut . þat late bygan to springe
>
> Þat to is kind eritage . mankunne schal bringe

The Digital SEL API the [Rails](https://rubyonrails.org/) backend of the Digital SEL, a digital
humanities project whose aim is to provide a sophistated, interactive digital edition of the
[South English Legendary](https://en.wikipedia.org/wiki/South_English_Legendary), an important
collection of [Middle English](https://en.wikipedia.org/wiki/Middle_English) [saints' lives](https://en.wikipedia.org/wiki/Hagiography) from the
[Middle Ages](https://en.wikipedia.org/wiki/Middle_Ages).

For more information about the project see the
[Digital SEL Blog](http://blog.digitalsel.org/). For a very very early version of the project
(written before the [maintainer](http://william-bolton.com/) was a software engineer) see the
[DigitalSEL.org](http://digitalsel.org/).

**_Caveat lector_**

This README is more verbose than most. It includes basic info for experienced software engineers,
but is also intended for readers who might need more context. If you have questions or suggestions,
feel free to open an issue.

If you are new to development and need help, please feel free to reach out to me via Twitter
[@william_ellet](https://twitter.com/william_ellet).

## Prerequisites

- [RVM](https://rvm.io/)
- Ruby 2.4.4
- Rails 5.2.0
- [PostgreSQL](https://www.postgresql.org/)

If you are not sure about how to install the prerequisites, follow this guide.

## Setup the project for development

After you have your database server running, create and migrate the database:

    rails db:create

    rails db:migrate

Run the server:

    rails s

## Run the tests

    rspec

## Run the linter

    rubocop
