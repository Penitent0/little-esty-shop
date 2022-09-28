class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price
  validates :quantity, numericality: true
  validates :unit_price, numericality: true

  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  enum status: { pending: 0, packaged: 1, shipped: 2}

  scope :revenue, -> { sum('invoice_items.quantity * invoice_items.unit_price') }
  scope :threshold, -> { where('invoice_items.quantity >= bulk_discounts.threshold') }
  scope :discount, -> { select('invoice_items.id, max((invoice_items.quantity * invoice_items.unit_price) * bulk_discounts.discount) as discount') }
end
