class Solution {
public:
    vector<int> findAnagrams(string s, string p) {
        vector<int> ans;

        vector<int> freq1(26,0);
        vector<int> freq2(26,0);

        //store freq count of p
        for(char ch : p){
            freq1[ch - 'a']++;
        }

        int left = 0;

        for(int right = 0;right < s.size();right++){
            //store freq of s

            freq2[s[right] - 'a']++;
            
            //mantain a fixed window size of p
            if(right - left + 1 > p.size()){
                freq2[s[left] - 'a']--;
                left++;
            }

            //compare freq 
            if(freq1 == freq2){
                ans.push_back(left);
                
            }
        }
        return ans;
    }
};