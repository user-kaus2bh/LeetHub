class Solution {
public:
    vector<int> rightSideView(TreeNode* root) {
        if (!root) return {};

        vector<int> ans;
        queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            int sz = q.size();

            for (int i = 0; i < sz; i++) {
                TreeNode* node = q.front();
                q.pop();

                if (i == 0) { // first node at this level
                    ans.push_back(node->val);
                }

                if (node->right) q.push(node->right);
                if (node->left) q.push(node->left);
            }
        }

        return ans;
    }
};