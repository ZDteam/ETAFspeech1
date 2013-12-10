function suc = confirm(v1,v2,ansi,ansj,ansk,feature_mat,thresholds)
    
    
    dist1 = dtw(v1 ,feature_mat{ansi,ansj,ansk,1});
    dist2 = dtw(v2, feature_mat{ansi,ansj,ansk,2});
    if(dist1 <= thresholds(ansi,ansj,1) && dist2 <= thresholds(ansi,ansj,2))
        suc = true;
    else
        suc = false;
    end
    
end