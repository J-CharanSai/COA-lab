#include<bits/stdc++.h>
#define ll long long
using namespace std;
const int maxn=2005,ha=1e9+7;
inline void add(int &x,int y){ x+=y; if(x>=ha) x-=ha;}
inline int ADD(int x,int y){ x+=y; return x>=ha?x-ha:x;}
int f[maxn][maxn],n,m,g[maxn],k,ans=0;
char s[maxn];

inline void solve(){
	f[n+1][0]=1;
	for(int i=n;i;i--){
		for(int j=0;j<=k;j++) add(g[j],f[i+1][j]*(ll)(s[i]-'a')%ha);

		int L=i-1,R=n+1;
		for(int j=0;j<=k;j++){
			while(j>=(n-L)*(L+2-i)&&L+1<R) L++;
			while(j>=(n-R+2)*(R-i)&&L+1<R) R--;
			for(int l=i;l<=L;l++) add(f[i][j],('z'-s[l])*(ll)f[l+1][j-(n-l+1)*(l-i+1)]%ha);
			for(int l=n;l>=R;l--) add(f[i][j],('z'-s[l])*(ll)f[l+1][j-(n-l+1)*(l-i+1)]%ha);
			add(f[i][j],g[j]);
		}

		add(f[i][0],1);
	}
}

int main(){
	scanf("%d%d",&n,&k);
	scanf("%s",s+1);
	solve();
	printf("%d\n",f[1][k]);
	return 0;
}
