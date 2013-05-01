module Spectifly
  module Types
    Native = [
      'boolean',
      'string',
      'date',
      'date_time',
      'integer',
      'decimal'
    ]

    Extended = {
      'percent' => {
        'Type' => 'Decimal',
      },
      'currency' => {
        'Type' => 'Decimal',
      },
      'year' => {
        'Type' => 'Integer'
      },
      'phone' => {}
    }
  end
end