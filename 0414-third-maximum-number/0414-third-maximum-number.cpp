class Solution {
public:
    int thirdMax(vector<int>& nums) {
       unordered_set<int> st;
       for(auto &it: nums){
        st.insert(it);
       }

        int first=INT_MIN;
        int second=INT_MIN, third=INT_MIN;

        for(int i=0; i<nums.size(); i++){
            if(nums[i]>first){
                third = second;
                second = first;
                first = nums[i];
            }
            else if(nums[i]>second && nums[i]!=first){
                  third = second;
                  second = nums[i];
                  
            }
            else if(nums[i]>third && nums[i]!=second && nums[i]!=first){
                third = nums[i];
            }

        }
        
        if(st.size()<3) return first;
        
        return third;
        
    }
};