function [img,info,time,srr,scc,rnn,lnn,lnws,rnws,ln,rn,no_ln,no_rn,suspected]=  BoundingBox( file )
   
tic;
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 %   i= imread('test2.png'); 
 i=imread(file);
 bw= graythresh(i);
    img1 = im2bw(i, bw); 
    img = ~img1;
    stats = regionprops(img, 'BoundingBox', 'Area');
    [row,~]=size(stats);
    hold on;
    %imshow(img);
    info=zeros(row,11); 
    for k = 1 : row
         for j=1:4
            info(k,j)=stats(k).BoundingBox(1,j); 
         end
         info(k,5)=stats(k).Area;
         len=stats(k).BoundingBox(3);
         width=stats(k).BoundingBox(4);
         info(k,6)=len*width;
         info(k,9)=min(len,width)/max(len,width);
         info(k,7)=info(k,5)/info(k,6);
    end
   
    for k=1:row
        nc=0;
        for j=1:row
            if(j~=k)
                if((info(k,1)<=info(j,1))&&((info(k,1)+info(k,3))>=(info(j,1)+info(j,3)))&&(info(k,2)<=info(j,2))&&((info(k,2)+info(k,4))>=(info(j,2)+info(j,4))))
                    nc=nc+1;
                end
            end
        end
        info(k,8)=nc;
    end
    scc=zeros(row,4000);
    
    srr=zeros(row,4000);
    for k=1:row
        sc=0;
        sr=0;
        for j=1:row
            if(j~=k)
                if (max(info(k,1),info(j,1))-min((info(k,1)+info(k,3)),(info(j,1)+info(j,3)))<0)
                    sc=sc+1;
                    scc(k,sc)=j;
                end
                if (max(info(k,2),info(j,2))-min((info(k,2)+info(k,4)),(info(j,2)+info(j,4)))<0)
                    sr=sr+1;
                    srr(k,sr)=j;
                end
            end
        end
        info(k,10)=sc;
        info(k,11)=sr;
    end
    for k=1:row
        thisBB = stats(k).BoundingBox;
        if(info(k,5)<=6 || info(k,7)<=0.06 || (info(k,9)<0.06 && info(k,3)<info(k,4)) || (info(k,8)>3))
            for i=info(k,1)-0.5:(info(k,1)-0.5+info(k,3))
                for j=info(k,2)-0.5:(info(k,2)-0.5+info(k,4))
                    img(j,i)=0;
                end
            end
           % rectangle('Position', thisBB, 'EdgeColor', 'y');
        end
    end
    imshow(img);
    counter=0;
    for k=1:row
        thisBB = stats(k).BoundingBox;
        if(info(k,5)>6 && info(k,7)>0.06 && (~(info(k,9)<0.06 && info(k,3)<info(k,4))) && (info(k,8)<=3))
            counter=counter+1;
            rectangle('Position', thisBB, 'EdgeColor', 'r');
        %else
         %   rectangle('Position', thisBB, 'EdgeColor', 'y');
        end
    end
    hold off;
    %info(1,1)=counter;
    rnn=[];
    lnn=[];
    for k=1:row
        co=1;
        req=0;
        reqq=0;
        min_dis=2000000;
        min_dist=2000000;
        while(srr(k,co)~=0)
            l=srr(k,co);
            dis=info(l,1)-info(k,1);
            dist=info(k,1)-info(l,1);
            if(dis>0 && dis<min_dis)
                min_dis=dis;
                req=l;
            end
            if(dist>0 && dist<min_dist)
                min_dist=dist;
                reqq=l;
            end
            co=co+1;
        end
        rnn(k)=req;
        lnn(k)=reqq;
    end
    lnws=[];
    rnws=[];
    for k=1:row
        lll=lnn(k);
        rrr=rnn(k);
        if(lll~=0)
            lnws(k)=info(k,1)-(info(lll,1)+info(lll,3));
        else
            lnws(k)=0;
        end
        if(rrr~=0)
            rnws(k)=info(rrr,1)-(info(k,1)+info(k,3));
        else
            rnws(k)=0;
        end
    end
        ln=zeros(row,3000);
        rn=zeros(row,3000);
        no_ln=[];
        no_rn=[];
        for k=1:row
            num_ln=0;
            num_rn=0;
            if(lnn(k)~=0)
                for j=1:row
                    if(rnn(j)==k)
                        num_ln=num_ln+1;
                        ln(k,num_ln)=j;
                    end
                end 
            end
            if(rnn(k)~=0)
                for j=1:row
                    if(lnn(j)==k)
                        num_rn=num_rn+1;
                        rn(k,num_rn)=j;
                    end
                end 
            end
            no_ln(k)=num_ln;
            no_rn(k)=num_rn;
        end    
        info_mean=mean(info);
        info_median=median(info);
        info_max=max(info);
        k1=max((info_mean(5)/info_median(5)),(info_median(5)/info_mean(5)));
        k2=max((info_mean(4)/info_median(4)),(info_median(4)/info_mean(4)));
        k3=max((info_mean(3)/info_median(3)),(info_median(3)/info_mean(3)));
        suspected=[];
        for k=1 :row
            if(info(k,5)==info_max(5) && (info(k,5)>(k1*info_median(5))))
                if((info(k,4)==info_max(4) && (info(k,4)>(k2*info_median(4)))) || (info(k,3)==info_max(3) && (info(k,3)>(k3*info_median(3)))))
                    suspected=[suspected k];
                end
            end
        end
        
    time=toc;
    display(k1);
    display(k2);
    display(k3);
    imwrite(img);
end
