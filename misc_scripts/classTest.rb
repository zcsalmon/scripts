class TestClass
    def initialize(name, value)
        @name=name
        @value=value
    end
    def getName()
        return @name
    end
    def getValue()
        return @value
    end
end


test1 = TestClass.new("Name", "Value")

puts test1.getName