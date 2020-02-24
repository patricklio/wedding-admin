class PhoneValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      PHONE_NUMBER_REGEX = /^((70|76|77|78|30|33))([0-9]{3})([0-9]{2})([0-9]{2})$/
      unless value.match?(PHONE_NUMBER_REGEX)
        record.errors[attribute] << (options[:message] || "n'est pas un numéro de téléphone valide")
      end
    end
  end