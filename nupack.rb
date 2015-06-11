class NuPack

    # Markup constants
    FLAT_MARKUP = 0.05
    PER_PERSON_MARKUP = 0.012
    
    # Material type hash
    @@material_markups = {
      drugs: 0.075,
      food: 0.13,
      electronics: 0.02
    }
    @@material_markups.default = 0 # No markup for other types
    
    def self.calculate_price(base_price, num_persons, material_types)
        final_price = base_price
        
        # Apply flat markup
        final_price = apply_markup(final_price, FLAT_MARKUP)
        
        # Calculate extra costs markup
        labour_markup = num_persons * PER_PERSON_MARKUP 
        extra_markup = labour_markup
        
        list_of_material_prices = material_types.map { |type| @@material_markups[type] }
        total_material_markup = list_of_material_prices.reduce(:+) || 0
        extra_markup += total_material_markup
        
        # Apply extra costs markup
        final_price = apply_markup(final_price, extra_markup)

        final_price
    end

    def self.apply_markup(price, markup)
      price + price * markup
    end

end