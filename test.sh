ALL_BRANCHES=`git ls-remote . | cut -d $'\t' -f 2` # THIS WILL INCLUDE THE FOLDER AS PREFIX
#echo $ALL_BRANCHES
string1="/refs/remotes/origin"
string2="heads"
string3="HEAD"
string4="master"
string5="development"
#IFS=, read -a patterns <<< "$string1"
#$INCLUDE_PATTERN
#for pattern in "${patterns[@]}"; do
#  includePattern+=" -e $REMOTE_FOLDER$pattern"
#  includePattern+=" -e $pattern"
#done

#branches=`echo "$ALL_BRANCHES" | eval "grep -P $includePattern"`
branches=`echo "$ALL_BRANCHES" | eval "grep -Pvw $string4" | eval "grep -Pvw $string5" | eval "grep -Pvw $string3" | eval "grep -Pvw $string2" | eval "grep -Pvw $string1"`

#branches=`echo "$ALL_BRANCHES" | eval "grep -Pvw $string1"`
#branches=`echo "$ALL_BRANCHES" | eval "grep $includePattern" | cut -d $'\t' -f 2 | cut -d $'/' -f 4`
#echo "B = $branches"
#echo $branches
#echo "C = git merge -q --no-edit $branches"

#git merge -q --no-edit $branches
#git checkout $branches

read -a arr <<<$branches

for refBranch in ${arr[@]}; do
 #echo $refBranch
 #echo $refBranch | cut -f5,4 -d'/'
 checkOutBranch=`echo "$refBranch" | cut -f5,4 -d'/'`
 echo $checkOutBranch
 git remote update
 git fetch origin
 git checkout $checkOutBranch
 git merge -v --no-edit origin/development
 git push
done

