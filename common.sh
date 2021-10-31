# Returns the number of processor cores available
# Usage: num_cpus
function num_cpus
{
    # This *should* be available on literally everything, including OSX
    cpus=`getconf _NPROCESSORS_ONLN 2>/dev/null`
    # fallback, dual core is a sane default
    [ -z "$cpus" ] && cpus="2"
    echo $cpus
}

# Trim leading zeroes of each numerical list element 
# Usage: trlz <numbers>
function trlz
{
	for number in $@; do
		echo $(expr $number + 0)
	done
}

# Extracts a file based on its extension
# Usage: extract <archive>
function auto_extract
{
    path=$1
    name=`echo $path|sed -e "s/.*\///"`
    ext=`echo $name|sed -e "s/.*\.//"`
    
    echo "Extracting $name..."
    
    case $ext in
        "tar") tar --no-same-owner -xf $path ;;
        "gz"|"tgz") tar --no-same-owner -xzf $path ;;
        "bz2"|"tbz2") tar --no-same-owner -xjf $path ;;
        "xz"|"txz") tar --no-same-owner -xJf $path ;;
        "zip") unzip $path ;;
        *) echo "I don't know how to extract $ext archives!"; return $(false) ;;
    esac
    
    return $?
}

# Downloads and extracts a file, with some extra checks.
# Usage: download_and_extract <url> <output?>
function download_and_extract
{
    url=$1
    name=`echo $url|sed -e "s/.*\///"`
    outdir=$2
    
    # If there are already an extracted directory, delete it, otherwise
    # reapplying patches gets messy.
    [ -d $outdir ] && echo "Deleting old version of $outdir" && rm -rf $outdir
    
    # First, if the archive already exists, attempt to extract it. Failing
    # that, attempt to continue an interrupted download. If that also fails,
    # remove the presumably corrupted file.
    [ -f $name ] && auto_extract $name || { wget --continue $url -O $name || rm -f $name; }
    
    # If the file does not exist at this point, it means it was either never
    # downloaded, or it was deleted for being corrupted. Just go ahead and
    # download it.
    # Using wget --continue here would make buggy servers flip out for nothing.
    [ -f $name ] || wget $url -O $name && auto_extract $name
}

# Clones or updates a Git repository.
# Usage: clone_git_repo <hostname> <user> <repo> <branch>
function clone_git_repo
{
    host=$1
    user=$2
    repo=$3
    branch=${4:-master}
    
    OLDPWD=$PWD
    
    # Try to update an existing repository at the target path.
    # Nuke it if it's corrupted and the pull fails.
    [ -d $repo/.git ] && { cd $repo && git pull; } || rm -rf $OLDPWD/$repo
    
    # The above command may leave us standing in the existing repo.
    cd $OLDPWD
    
    # If it does not exist at this point, it was never there in the first place
    # or it was nuked due to being corrupted. Clone and track $branch, please.
    [ -d $repo ] || git clone --recursive --depth 1 -b $branch https://$host/$user/$repo.git $repo || return $(false)
}
