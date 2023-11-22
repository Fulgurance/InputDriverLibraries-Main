class Target < ISM::Software
    
    def prepare
        @buildDirectory = true
        super

        runMesonCommand(["setup",@buildDirectoryName],mainWorkDirectoryPath)
    end

    def configure
        super

        runMesonCommand([   "--prefix=/usr",
                            "--buildtype=release",
                            "-Ddebug-gui=false",
                            "-Dtests=false",
                            "-Ddocumentation=false",
                            "-Dlibwacom=false",
                            "-Dudev-dir=/usr/lib/udev"],
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
