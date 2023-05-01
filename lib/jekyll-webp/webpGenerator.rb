require 'fileutils'

module Jekyll
  module Webp

    #
    # A static file to hold the generated webp image after generation
    # so that Jekyll will copy it into the site output directory
    class WebpFile < ::Jekyll::StaticFile
      def write(dest)
        true # Recover from strange exception when starting server without --auto
      end
    end #class WebpFile

    class WebpGenerator < ::Jekyll::Generator
      # This generator is safe from arbitrary code execution.
      safe true

      # This generator should be passive with regard to its execution
      priority :lowest


      def process_img(imgfile, img_props, site, threads)
        outfile_fullpath_webp = img_props[:outfile_fullpath_webp]

        # Generate the file
        if @config["async"]
          threads << Thread.new do
            WebpExec.run(@config['quality'], @config['flags'], imgfile, outfile_fullpath_webp, @config['webp_path'])
          end
        else
          WebpExec.run(@config['quality'], @config['flags'], imgfile, outfile_fullpath_webp, @config['webp_path'])
        end
      end # img_dir


      # Generate paginated pages if necessary (Default entry point)
      # site - The Site.
      #
      # Returns nothing.
      def generate(site)

        # Retrieve and merge the configuration from the site yml file
        @config = DEFAULT.merge(site.config['webp'] || {})

        # If disabled then simply quit
        if !@config['enabled']
          Jekyll.logger.info "WebP:","Disabled in site.config."
          return
        end

        Jekyll.logger.debug "WebP:","Starting"

        # If the site destination directory has not yet been created then create it now. Otherwise, we cannot write our file there.
        Dir::mkdir(site.dest) if !File.directory? site.dest


        files = find_files(site)
        puts "--------------"
        pp files
        puts "--------------"

        # Counting the number of files generated
        file_count = 0

        # Iterate through every image in each of the image folders and create a webp image
        # if one has not been created already for that image.
        threads = []
        files.each do |imgfile, img_props|
          process_img(imgfile, img_props, site, threads)
        end
        Jekyll.logger.info "Thread count: #{threads.size}"
        threads.each(&:join)

        # Keep the webp file from being cleaned by Jekyll
        files.each do |imgfile, img_props|
          outfile_fullpath_webp, imgdir, imgfile_relative_path, outfile_filename = img_props[:outfile_fullpath_webp], img_props[:imgdir], img_props[:imgfile_relative_path], img_props[:outfile_filename]
          if File.file?(outfile_fullpath_webp)
            site.static_files << WebpFile.new(site,
                                              site.dest,
                                              File.join(imgdir, imgfile_relative_path),
                                              outfile_filename)
          end
        end
      end


      def find_files(site)
        files = {}
        # If nesting is enabled, get all the nested directories too
        if @config['nested']
          newdir = []
          for imgdir in @config['img_dir']
            # Get every directory below (and including) imgdir, recursively
            # jy
            formatted = Dir.glob("." + imgdir + "/**/").map { |el| el[1..-1] }
            newdir += formatted
          end
          @config['img_dir'] = newdir
        end
        @config['img_dir'].each do |imgdir|
          imgdir_source = File.join(site.source, imgdir)
          imgdir_destination = File.join(site.dest, imgdir)
          FileUtils::mkdir_p(imgdir_destination)
          Jekyll.logger.info "WebP:","Processing #{imgdir_source}"

          # handle only jpg, jpeg, png and gif
          for imgfile in Dir[imgdir_source + "**/*.*"]
            imgfile_relative_path = File.dirname(imgfile.sub(imgdir_source, ""))

            # Skip empty stuff
            file_ext = File.extname(imgfile).downcase

            # If the file is not one of the supported formats, exit early
            next if !@config['formats'].include? file_ext

            # TODO: Do an exclude check
            # Create the output file path
            outfile_filename = if @config['append_ext']
                                 File.basename(imgfile) + '.webp'
                               else
                                 file_noext = File.basename(imgfile, file_ext)
                                 file_noext + ".webp"
                               end

            FileUtils::mkdir_p(imgdir_destination + imgfile_relative_path)
            outfile_fullpath_webp = File.join(imgdir_destination + imgfile_relative_path, outfile_filename)

            Jekyll.logger.info("WEBP CONFIG: #{@config}")

            # Check if the file already has a webp alternative?
            # If we're force rebuilding all webp files then ignore the check
            # also check the modified time on the files to ensure that the webp file
            # is newer than the source file, if not then regenerate
            if @config['regenerate'] || !File.file?(outfile_fullpath_webp) || File.mtime(outfile_fullpath_webp) <= File.mtime(imgfile)
              Jekyll.logger.info "WebP:", "Change to source image file #{imgfile} detected, regenerating WebP"
              files[imgfile] = {
                outfile_fullpath_webp: outfile_fullpath_webp,
                imgdir: imgdir,
                outfile_filename: outfile_filename,
                imgfile_relative_path: imgfile_relative_path,
              }

              ## don't filter these out
            end
          end # dir.foreach
        end
        files
        # Jekyll.logger.info "WebP:","Generator Complete: #{file_count} file(s) generated"
      end

    end #class WebPGenerator

  end #module Webp
end #module Jekyll
