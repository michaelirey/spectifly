# Spectifly

Say you've been tasked with building a web service that accepts a purchase
order in XML format, adds some additional fields, sends the modified purchase
order to another web service via JSON, receives a JSON response with fulfillment
details, and finally sends back the same order with all this additional data
back to the original client, via XML.  You've been given specifications for
what fields the purchase order needs to have at every step of the process, and
you need to validate the object differently for each transaction.

Spectifly is here to help.  It's a library with a highly opinionated markup language (based on YAML) for specifying entities and their presentations (using
`*.entity` files), and uses these entity specifications to generate XSDs, JSON
validators, and fixture data for testing.

## Installation

Add this line to your application's Gemfile:

    gem 'spectifly'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spectifly

## Usage

The Spectifly markup language is a subset of YAML. Only one root node is allowed
per file (since a single `.entity` file represents a single business entity),
and there are other restrictions, as well as additional features, which we'll
discuss here.

Here's an example entity:

```YAML
Widget:
  Description: A widget produced by WidgetCo
  Fields:
    Name*:
      Description: Display name of widget

    Created At:
      Description: When the widget was built
      Type: DateTime

    Awesome?:
      Description: Whether or not the widget is awesome
```

The root node, `Widget:` above, is required, and there can be only one node at
this level.

Directly below the root node, the only valid nodes are `Description` and
`Fields`.  The `Description` is a plain language description of the entity.

### Fields

`Fields` is a YAML tree with one or more field entries, which have their own
specification.  The key of a field node is the field's name, and the value can
either be null, or another tree with several possible keys, all of which are
optional themselves:

* `Description` (string): A plain-language description of the variable
* `Multiple` (Boolean): Whether or not this variable can occur multiple times
* `Type` (string): Type of data contained in this field (defaults to String)
* `Validations` (string or list of strings): Restrictions on the values allowed
  in this field
* `Valid Values` (list of strings): List of possible literal values for this
  field
* `Minimum Value` (numeric): Minimum value allowed for this field (numeric
  fields only)
* `Maximum Value` (numeric): Maximum value allowed for this field (numeric
  fields only)

#### Special Tokens

The key of the field node (the name of the field) can also end with one or two
special "tokens":

* The `*` token, as in the `Name*` field in the above example, makes the field
  required, which means it must occur once (or at least once, for Multiple
  fields).
* The `?` token, as in the example's `Awesome?` field, sets `Type` to Boolean.

These tokens can be combined, if you have a required Boolean field.

If the `?` shortcut conflicts with the explicit key (e.g. a `Rad?` field with
`Type: String`), an exception will be thrown during parsing.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request