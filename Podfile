workspace 'VehicleFinder'
use_frameworks!

platform :ios, '12.2'

def app_pods
    pod 'RxSwift',    '~> 5'
    pod 'RxCocoa',    '~> 5'
end

def module_pods
    pod 'RxSwift',    '~> 5'
    pod 'RxCocoa',    '~> 5'
end

def testing_pods
    pod 'Nimble'
    pod 'Quick'
    # Rx
    pod 'RxBlocking', '~> 5'
    pod 'RxTest',     '~> 5'
end

target "VehicleModule" do 
   module_pods 
end

target "VehicleFinder" do 
   app_pods 
end

target "VehicleModuleTests" do
    testing_pods
end

target "VehicleFinderTests" do
    testing_pods
end

