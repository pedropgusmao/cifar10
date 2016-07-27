package = "cifar10"
version = "scm-1"

source = {
	url = "git://github.com/pedropgusmao/cifar10.git"
}

description = {
	summary = "CIFAR-10 Dataset",
	detailed = [[
		    ]],
	homepage = "https://github.com/pedropgusmao/cifar10",
	license = "BSD"
} 

dependencies = {
	"torch >= 7.0",
	"paths >= 1.0",
}
			
build = {
	type = "builtin",
	modules = {
		["cifar10.init"] = "init.lua"
	},

	install = {
		lua = {
		-- this is ugly (but this is luarocks)
			["cifar10.data.train-images-idx3-ubyte"] = "data/train-images-idx3-ubyte",
			["cifar10.data.train-labels-idx1-ubyte"] = "data/train-labels-idx1-ubyte",
			["cifar10.data.t10k-images-idx3-ubyte"] = "data/t10k-images-idx3-ubyte",
			["cifar10.data.t10k-labels-idx1-ubyte"] = "data/t10k-labels-idx1-ubyte"
		}
	}
}
