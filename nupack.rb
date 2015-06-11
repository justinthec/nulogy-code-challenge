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
    
    def self.calculate(base_price, num_persons, material_types)
        final_price = base_price
        
        # Apply flat markup
        final_price += final_price * FLAT_MARKUP 
        
        # Apply extra costs markup

        # Apply labour markup
        labour_markup = num_persons * PER_PERSON_MARKUP 
        extra_markup = labour_markup
        
        #Apply material markup
        material_prices = material_types.map { |type| @@material_markups[type] }
        total_material_markup = (material_prices.empty?) ? 0 : material_prices.reduce(:+)
        extra_markup += total_material_markup
        
        final_price += final_price * extra_markup
        
        final_price
    end

end