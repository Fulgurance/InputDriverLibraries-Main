class Target < ISM::Software
    
    def prepare
        @buildDirectory = true
        super

        runMesonCommand(["setup",@buildDirectoryNames["MainBuild"],"-Dlibwacom=false","-Ddebug-gui=false"],mainWorkDirectoryPath)
    end

    def configure
        super

        runMesonCommand([   "configure",
                            @buildDirectoryNames["MainBuild"],
                            "--prefix=/usr",
                            "--buildtype=release",
                            "-Ddebug-gui=false",
                            "-Dtests=false",
                            "-Ddocumentation=false",
                            "-Dlibwacom=false",
                            "-Dudev-dir=/usr/lib/udev",
                            "-Ddebug-gui=false"],
                            mainWorkDirectoryPath)
    end
    
    def build
        super

        runNinjaCommand(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        runNinjaCommand(["install"],buildDirectoryPath,{"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
    end

end
