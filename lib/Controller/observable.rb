module Controller
  module Observable

    def addObserver(observer)
      @observers = Array.new if @observers.nil?
      @observers.push(observer)    
    end

    def notifyAll
      @observers.each {|observer|
        observer.notify
      }
    end   

  end
end
