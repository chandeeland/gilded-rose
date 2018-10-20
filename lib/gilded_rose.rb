# frozen_string_literal: true

class GildedRose
  class NormalItem
    def initialize(days_remaining, quality)
      @days_remaining = days_remaining
      @quality = quality
    end

    attr_reader :days_remaining, :quality

    def tick
      change_quality
      change_days_remaining
      @quality = 0 if quality < 0
    end

    private

    def change_days_remaining
      @days_remaining -= 1
    end

    def change_quality
      @quality -= 1
      @quality -= 1 if days_remaining <= 0
    end
  end

  class AgedBrie < NormalItem
    private

    def change_quality
      @quality += 1
      @quality += 1 if days_remaining <= 0
      @quality = 50 if quality > 50
    end
  end

  class BackstagePasses < NormalItem
    private

    def change_quality
      @quality -= 1 if days_remaining > 10
      @quality -= 1 if days_remaining > 5
      @quality += 3 if days_remaining > 0
      @quality = 0 if days_remaining <= 0
      @quality = 50 if quality > 50
    end
  end

  class ConjuredManaCake < NormalItem
    private

    def change_quality
      @quality -= 2 if days_remaining <= 0
      @quality -= 2
    end
  end

  class Sulfuras < NormalItem
    private

    def change_quality; end

    def change_days_remaining; end
  end

  attr_reader :name, :item

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @item = item_klass(name).new(days_remaining, quality)
  end

  def tick
    item.tick
  end

  def days_remaining
    item.days_remaining
  end

  def quality
    item.quality
  end

  private

  def item_klass(name)
    {
      'Normal Item' => NormalItem,
      'Aged Brie' => AgedBrie,
      'Sulfuras, Hand of Ragnaros' => Sulfuras,
      'Backstage passes to a TAFKAL80ETC concert' => BackstagePasses,
      'Conjured Mana Cake' => ConjuredManaCake
    }.fetch(name, NormalItem)
  end
end
