class AddressDecorator < Draper::Decorator
  delegate_all

  def to_html
    [ flat, street, "#{city}, #{postal_code}" ].compact.join("<br/>").html_safe
  end

  def for_map
    [ flat, street, city, postal_code ].compact.join(",+")
  end

  def to_s
    [ flat, street, city, postal_code ].compact.join(", ")
  end
end
