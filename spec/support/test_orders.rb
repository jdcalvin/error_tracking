class TestOrders

  attr_reader :user, :organization, :order_type, :tasks, :categories

  def initialize
    @user = FactoryBot.create(:user)
    @organization = @user.organization
    @order_type = OrderType.create(title: "Basic", organization: user.organization)
    build_data!
  end

  def all_orders
    order_type.orders
  end

  def create_order_with_errors_on(*tasks_with_errors)
    if tasks_with_errors.blank?
      raise ArgumentError.new "call method as create_order_with_errors_on('A-1','A-2','B-3') etc."
    end
    new_order = Order.create(order_type: order_type, order_name: 'test order', user: user, error: true, note: 'blah')
    error_tasks = tasks.where(description: tasks_with_errors)
    passed_tasks = tasks.where.not(description: tasks_with_errors)

    error_tasks.each do |t|
      Validation.create(task: t, order: new_order, approval: true)
    end
    passed_tasks.each do |t|
      Validation.create(task: t, order: new_order, approval: false)
    end

    new_order
  end

  def create_order_without_errors
    new_order = Order.create(order_type: order_type, order_name: 'test order', user: user, error: false)
    tasks.each do |t|
      Validation.create(task: t, order: new_order, approval: false)
    end
    new_order
  end

  private

  def c_1
    categories.first
  end

  def c_2
    categories.last
  end

  def tasks
    order_type.tasks
  end

  def build_data!
    build_categories
    @categories = order_type.categories
    build_tasks
    @tasks = order_type.tasks
  end

  def build_tasks
    Task.create(description: 'A-1', category: c_1)
    Task.create(description: 'A-2', category: c_1)
    Task.create(description: 'B-1', category: c_2)
    Task.create(description: 'B-2', category: c_2)
    Task.create(description: 'B-3', category: c_2)
  end

  def build_categories
    c1 = Category.create(name: 'A', order_type: order_type)
    c2 = Category.create(name: 'B', order_type: order_type)
  end

  def base
    let(:user) { FactoryBot.create(:user)}
    let(:test_order) { FactoryBot.create(:order, :empty, user: user) }
    let(:order_type) { OrderType.create(title: "Basic", organization: user.organization)}
  end
end
