require 'spec_helper'

describe NuPack do
  describe "#calculate" do
    context "when there are no extra costs" do
      people = 0
      types = []

      it "applies a flat markup of 5%" do
        price = 1000.00

        expected_value = price * 1.05

        expect(NuPack.calculate(price,people,types)).to eql(expected_value)
      end
    end

    context "when there are extra costs" do
      context "and there are only labour costs" do
        people = 4 
        types = []

        it "applies a labour markup of 1.2% per person on top of the flat markup" do
          price = 1000.00

          flat_markup_price = price * 1.05 
          labour_markup = people * 0.012

          expected_value = flat_markup_price * (1 + labour_markup)

          expect(NuPack.calculate(price,people,types)).to eql(expected_value)
        end
      end

      context "and there are no labour costs" do
        people = 0 

        context "and the material type is pharmaceuticals" do
          it "applies a material markup of 7.5% on top of the flat markup" do
            price = 1000.00
            types = [:drugs]

            flat_markup_price = price * 1.05 

            expected_value = flat_markup_price * (1 + 0.075)

            expect(NuPack.calculate(price,people,types)).to eql(expected_value)
          end
        end

        context "and the material type is food" do
          it "applies a material markup of 13% on top of the flat markup" do
            price = 1000.00
            types = [:food]

            flat_markup_price = price * 1.05 

            expected_value = flat_markup_price * (1 + 0.13)

            expect(NuPack.calculate(price,people,types)).to eql(expected_value)
          end
        end

        context "and the material type is electronics" do
          it "applies a material markup of 2% on top of the flat markup" do
            price = 1000.00
            types = [:electronics]

            flat_markup_price = price * 1.05 

            expected_value = flat_markup_price * (1 + 0.02)

            expect(NuPack.calculate(price,people,types)).to eql(expected_value)
          end
        end

        context "and the material type is something else" do
          it "applies no material markup on top of the flat markup" do
            price = 1000.00
            types = [:other]

            flat_markup_price = price * 1.05 

            expected_value = flat_markup_price

            expect(NuPack.calculate(price,people,types)).to eql(expected_value)
          end
        end

        context "and there are multiple material types" do
          it "applies a material markup for each of the types on top of the flat markup" do
            price = 1000.00
            types = [:drugs, :food, :apples, :other, :electronics]

            flat_markup_price = price * 1.05 

            expected_value = flat_markup_price * (1 + 0.075 + 0.13 + 0 + 0 + 0.02)

            expect(NuPack.calculate(price,people,types)).to eql(expected_value)
          end
        end
      end

      context "when there are labour and material costs" do
        people = 7
        types = [:electronics, :bananas, :drugs]

        it "applies a labour markup per person and material markup for each of the types on top of the flat markup" do
          price = 1000.00

          flat_markup_price = price * 1.05 
          labour_markup = people * 0.012

          expected_value = flat_markup_price * (1 + labour_markup + 0.02 + 0 + 0.075)

          expect(NuPack.calculate(price,people,types)).to eql(expected_value)
        end
      end
    end
  end
end
