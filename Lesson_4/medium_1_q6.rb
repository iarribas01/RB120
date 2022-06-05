class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231" # directly access instance var
  end

  def show_template
    template # use of getter
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231" # use of setter
  end

  def show_template
    self.template # redundant use of self
  end
end